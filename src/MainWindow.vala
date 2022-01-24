namespace FourK {
	public class MainWindow : Hdy.ApplicationWindow {
		private Hdy.HeaderBar header_bar;
		private Hdy.Deck deck;
		private Views.GameView game_view;
		private Controllers.Game game_controller;

		private GLib.Settings settings;
		private int window_x;
		private int window_y;

		public MainWindow (FourK.Application fourk_app) {
			Object (
				application: fourk_app,
				title: "FourK",
				default_height: 640,
				default_width: 360,
				resizable: false
			);
		}

		construct {
			Hdy.init ();
			var global_grid = new Gtk.Grid ();
			global_grid.orientation = Gtk.Orientation.VERTICAL;

			game_controller = new Controllers.Game (this);
			game_view = game_controller.get_game_view ();
			game_view.quit_game_requested.connect (on_game_view_quit_requested);

			setup_header_bar ();
			setup_deck ();
			global_grid.set_vexpand (true);

			global_grid.add (header_bar);
			global_grid.add (deck);
			add (global_grid);

			settings = new GLib.Settings ("com.github.keilith-l.fourk");
			settings.get ("window-position", "(ii)", out window_x, out window_y);
			if (window_x != -1 || window_y != -1) {
				move (window_x, window_y);
			}

			delete_event.connect (on_delete_event);
		}

		private void setup_header_bar () {
			header_bar = new Hdy.HeaderBar (){
				hexpand = true,
				has_subtitle = false,
				show_close_button = true,
				title = "Fourk"
			};
		}

		private void setup_deck () {
			deck = new Hdy.Deck ();
			deck.set_vexpand (true);
			deck.set_valign (Gtk.Align.START);
			deck.set_transition_type (Hdy.DeckTransitionType.UNDER);
			deck.add (game_view);
		}

		private bool on_delete_event (Gdk.EventAny event) {
			get_position (out window_x, out window_y);
			settings.set("window-position", "(ii)", window_x, window_y);
			return false;
		}

		private void on_game_view_quit_requested () {
			get_position (out window_x, out window_y);
			settings.set("window-position", "(ii)", window_x, window_y);
			application.quit ();
		}
	}
}
