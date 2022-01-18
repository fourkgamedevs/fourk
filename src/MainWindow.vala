namespace FourK {
	public class MainWindow : Hdy.ApplicationWindow {
		private Hdy.HeaderBar header_bar;
		private Hdy.Deck deck;

		public MainWindow (FourK.Application eksanos_app) {
			Object (
				application: eksanos_app,
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

			setup_header_bar ();
			setup_deck ();

			global_grid.add (header_bar);
			global_grid.add (deck);
			add (global_grid);
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
			deck.set_transition_type (Hdy.DeckTransitionType.UNDER);
		}
	}
}
