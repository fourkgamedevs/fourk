project('com.github.keilith.fourk', 'vala', 'c')

executable(
	meson.project_name(),
	'src'/'Application.vala',
	'src'/'MainWindow.vala',
	'src'/'Widgets'/'BoardGrid.vala',
	'src'/'Widgets'/'Tile.vala',
	'src'/'Widgets'/'ScoreBox.vala',
	'src'/'Views'/'GameView.vala',
	'src'/'Controllers'/'Game.vala',
	'src'/'Models'/'Game.vala',
	dependencies: [
		dependency('libhandy-1', version: '>=0.91.0'),
		dependency('granite'),
		dependency('gtk+-3.0'),
		dependency('glib-2.0'),
		meson.get_compiler('c').find_library('m', required : false)
	],
	install: true
)


install_data(
	'data'/'fourk.desktop',
	install_dir: get_option('datadir') / 'applications',
	rename: meson.project_name() + '.desktop'
)

install_data(
	'data' / 'fourk.metainfo.xml',
	install_dir: get_option('datadir') / 'metainfo',
	rename: meson.project_name() + '.metainfo.xml'
)
