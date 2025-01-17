build:
	rm -rf build && mkdir build
	ruby wruby.rb

clean:
	rm -rf build/*

.PHONY: build clean

	find . -type f \( -name "*.html" -o -name "*.css" -o -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) -exec gzip -k -f {} \;
