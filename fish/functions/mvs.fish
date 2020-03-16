function mvs
  for file in (find -type f -name "*$argv[1]*")
    set to (echo $file | sed -e 's/'$argv[1]'/'$argv[2]'/g')
    printf '%s%s%s%s%s%s%s\n' \
      (echo "move ") \
      (set_color green) \
      (echo "$file ") \
      (set_color normal) \
      (echo "to ") \
      (set_color green) \
      (echo "$to")
    mv $file $to
  end
end
