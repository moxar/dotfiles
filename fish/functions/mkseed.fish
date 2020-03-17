function mkseed
  printf "%s%s\n" (date +%Y_%m_%d_%H_%I_%S) $argv
end
