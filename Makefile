test: tests
tests:
	python2 -m coverage run -m keyboarded._keyboard_tests
	python2 -m coverage run -am keyboarded._mouse_tests
	python -m coverage run -am keyboarded._keyboard_tests
	python -m coverage run -am keyboarded._mouse_tests
	python -m coverage report && coverage3 html

build: tests keyboard setup.py README.md CHANGES.md MANIFEST.in
	python ../docstring2markdown/docstring2markdown.py keyboarded "https://github.com/jecrs/keyboarded/blob/master" > README.md
	find . \( -name "*.py" -o -name "*.sh" -o -name "* .md" \) -exec dos2unix {} \;
	python setup.py sdist --format=zip bdist_wheel && twine check dist/*

release:
	python make_release.py

clean:
	rm -rfv dist build coverage_html_report keyboard.egg-info
