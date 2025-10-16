build:
	rm -rf build && mkdir build
	ruby wruby.rb
clean:
	rm -rf build/*
serve: build
	find posts pages public _config.yml wruby.rb -type f | \
		entr -r sh -c 'ruby wruby.rb && echo "✅ Rebuilt at $$(date)"' &
	cd build && python3 -m http.server 3003

.PHONY: build clean serve