function fish_prompt --description 'Write out the prompt'

    if test (git status --porcelain 2> /dev/null | grep -E "^ (M|D)" | wc -l) -ge 1
        set symbol "*"
    else if test (git status --porcelain 2> /dev/null | grep -E "^(M|A|D|R|C)" | wc -l) -ge 1
        set symbol "+"
    end

    set branch (git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')

    set current_path (echo (pwd) | sed 's/\/home\/'$USER'/~/g')
    printf "%s%s %s%s%s %s%s%s%s%s%s" \
        (set_color -o yellow) \
        (date +%T) \
        (set_color blue) \
        $USER \
        (set_color green) \
        $current_path \
        (set_color red) \
        (echo " $branch$symbol") \
        (set_color normal) \
        (echo " > ")
end
