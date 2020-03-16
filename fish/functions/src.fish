function src
  for line in (cat $argv)
    set all (echo $line |tr = \n)
    set val (echo $line | sed -e 's/'$all[1]='//')
    if test -n $val
      set -gx $all[1] $val
    end
  end
end
