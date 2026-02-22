#!/usr/bin/env bb
(require
  '[babashka.cli :as cli]
  '[babashka.fs :as fs]
  '[clojure.java.shell :refer [sh]]
  '[clojure.math :as math])

(def ffmpeg-video-filter 
  "Change to 1280x720, preserving the orientation and ration (typically 16:9 or 9:16) and padding with black stripes"
  "scale=iw*min(1280/iw\\,720/ih):ih*min(1280/iw\\,720/ih),pad=1280:720:(1280-iw*min(1280/iw\\,720/ih))/2:(720-ih*min(1280/iw\\,720/ih))/2")

(defn compress-video! [file-path dry-run?]
  (let [path-str (str file-path)
        [path-no-ext _ext] (fs/split-ext file-path)
        temp-path (str path-no-ext ".temp.mp4")]
    (println (if dry-run? "Would process:" " Processing:") 
      path-str)
    
    (when-not dry-run?
     (let [{:keys [exit err]} 
           (sh "ffmpeg" "-y" "-i" path-str
             "-vf" ffmpeg-video-filter
             "-c:v" "libx265" ; use the modern HEVC (H.265) codec; https://trac.ffmpeg.org/wiki/Encode/H.265
             "-crf" "20" ; quality (0-51): the lower the better & bigger, 28 default & sweet spot for mobiles
             "-tag:v" "hvc1" ; hint for QuickTime and Apple Photos
             "-c:a" "aac" ; audio recoding/handling: could also try aac, copy, mp3
             temp-path)]
       
       (if (zero? exit)
         (do
           (fs/move temp-path file-path {:replace-existing true})
           (println "Done:" path-str))
         (do
           (println "Error processing" path-str ":" err) 
           (when (fs/exists? temp-path) (fs/delete temp-path))
           (throw (Exception. (str "Error processing" path-str ":" err)))))))))

(def cli-opts {:spec {:dry-run {:alias :d :coerce :boolean :desc "Print files without compressing"}}})

(defn -main [cli-args]
  (let [{dry-run? :dry-run :as _opts} (cli/parse-opts cli-args cli-opts)
        root-dir "."]

    (when dry-run? (println "--- DRY RUN MODE ENABLED ---"))
    (println "Searching for videos in" (str (fs/absolutize root-dir)) "...")

    (let [videos (fs/glob root-dir "**.{mp4,mov,m4v}")
          start (System/currentTimeMillis)]
      (if (empty? videos)
        (println "No matching video files found.")
        (run! #(compress-video! % dry-run?) videos))

      (println "Done" (if dry-run? "checking" "compressing") (count videos) "videos in"
        (math/round (/ (- (System/currentTimeMillis) start)
                       60000))
        " minutes"))))

(-main *command-line-args*)
