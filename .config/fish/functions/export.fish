function export --description "Emulate bash' export so that we can copy&paste from utilities that produce it"
    if [ $argv ] 
        set var (echo $argv | cut -f1 -d=)
        set val (echo $argv | cut -f2 -d=)
        set -g -x $var $val
    else
        echo 'export var=value'
    end
end
# Source: Lars Blumberg at https://stackoverflow.com/a/29387647/204205
