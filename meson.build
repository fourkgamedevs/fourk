project('com.github.fourkgamedevs.fourk', 'vala', 'c')

gnome = import('gnome')

gresource = gnome.compile_resources(
	'gresource',
	'data'/'gresource.xml',
	source_dir: 'data'
)

executable(
	meson.project_name(),
	gresource,
	'src'/'Application.vala',
	'src'/'MainWindow.vala',
	'src'/'Widgets'/'BoardGrid.vala',
	'src'/'Widgets'/'Tile.vala',
	'src'/'Widgets'/'ScoreBox.vala',
	'src'/'Widgets'/'GameOverDialog.vala',
	'src'/'Widgets'/'VictoryDialog.vala',
	'src'/'Views'/'GameView.vala',
	'src'/'Controllers'/'Game.vala',
	'src'/'Models'/'Game.vala',
	'src'/'Models'/'Board.vala',
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

icon_sizes = ['16', '24', '32', '48', '64', '128']

foreach i : icon_sizes
	install_data(
		'data' / i + '.svg',
		install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i / 'apps',
		rename: meson.project_name() + '.svg'
	)
	install_data(
		'data' / i + '.svg',
		install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i + '@2' / 'apps',
		rename: meson.project_name() + '.svg'
	)
endforeach

meson.add_install_script('meson/post_install.py')

subdir('data')
