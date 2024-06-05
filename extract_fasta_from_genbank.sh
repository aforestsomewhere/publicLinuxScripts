awk '/^ORIGIN/,/^\/\//' my_twisted_genbank.gbk | awk 'NR>1 {gsub(/[0-9 \t]/, ""); print}' | tr -d '\n'
