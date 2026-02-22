#!/usr/bin/env bb
(require
  '[babashka.fs :as fs]
  '[clojure.java.shell :refer [sh]]
  '[clojure.math :as math]
  '[clojure.string :as str])

(-> (fs/path "/root/file.mp3")
    (fs/split-ext))

(defn video-file? [path]
  (let [ext (str/lower-case (fs/extension path))]
    (contains? #{"mp4" "mov" "m4v"} ext)))

(defn compress-video! [file-path]
  (let [path-str (str file-path)
        [path-no-ext _ext] (fs/split-ext file-path)
        temp-path (str path-no-ext ".temp.mp4")]
    (println "Processing:" path-str)
    
    (let [{:keys [exit err]}
          (sh "ffmpeg" "-y" "-i" path-str
              "-vf" "scale=iw*min(800/iw\\,600/ih):ih*min(800/iw\\,600/ih),pad=800:600:(800-iw*min(800/iw\\,600/ih))/2:(600-ih*min(800/iw\\,600/ih))/2"
            ;; Scaling: Mobile phones often record in 16:9 or 9:16. This specific string scales the video to fit
            ;; within 800x600 while maintaining the original aspect ratio (no stretching). Adds black bars if smaller.
              "-c:v" "libx265" ; use the modern HEVC (H.265) codec
              "-crf" "28" ; quality: the lower the better & bigger, 28 sweet spot for mobiles
              "-tag:v" "hvc1" ; hint for QuickTime and Apple Photos
              "-c:a" "mp3"
              temp-path)]
      
      (if (zero? exit)
        (do
          (fs/move temp-path file-path {:replace-existing true})
          (println "Done:" path-str))
        (do
          (println "Error processing" path-str ":" err)
          (when (fs/exists? temp-path) (fs/delete temp-path))
          (throw (Exception. (str "Error processing" path-str ":" err))))))))

;; Main execution
(let [root-dir "."]
  (println "Searching for videos in" (fs/absolutize root-dir) "...")
  (let [video-paths
        (->> (fs/glob root-dir "**/*")
             (filter video-file?))
        start (System/currentTimeMillis)]
    (println "Going to compress" (count video-paths) "videos...")
    (run! compress-video! video-paths)
    (println "Done compressing" (count video-paths) "videos in"
      (math/round (/ (- (System/currentTimeMillis) start)
                     60000))
      " minutes")))