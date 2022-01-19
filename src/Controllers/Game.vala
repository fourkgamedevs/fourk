namespace FourK.Controllers {
	internal class Game : GLib.Object {
		private Views.GameView game_view;
		private Models.Game game_model;
		private Gtk.EventControllerKey key_event_controller;

		public Game (Hdy.ApplicationWindow window) {
			game_view = new Views.GameView ();
			game_model = new Models.Game ();
			key_event_controller = new Gtk.EventControllerKey (window);
			key_event_controller.key_pressed.connect (on_key_pressed);
			//GLib.Timeout.add_seconds_full (GLib.Priority.DEFAULT, 2, test_board_update);
		}

		public Views.GameView get_game_view () {
			return game_view;
		}

		public bool on_key_pressed (uint keyval, uint keycode, Gdk.ModifierType state) {
			if(keyval == Gdk.Key.Left) {
				game_model.start_new_game ();
				int[,] board_state = game_model.get_board_state ();
				game_view.update_board (board_state);
				return true;
			}
			return false;
		}

		private bool test_board_update () {
			int[,] test_state = new int[4,4];
			for (int r = 0; r < 4; r++) {
				for (int c = 0; c < 4; c++) {
					int val = GLib.Random.int_range(0, 13);
					val = (int) GLib.Math.pow(2.0, (double)val);
					test_state[c,r] = val;
				}
			}
			game_view.update_board (test_state);
			return true;
		}
	}
}
