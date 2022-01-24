namespace FourK.Controllers {
	internal class Game : GLib.Object {
		private Views.GameView game_view;
		private Models.Game game_model;
		private Gtk.EventControllerKey key_event_controller;

		private int next_milestone_value;
		private string next_milestone_message;

		public Game (Hdy.ApplicationWindow window) {
			game_view = new Views.GameView (window);
			game_model = new Models.Game ();

			game_model.board_updated.connect (on_model_board_updated);
			game_view.new_game_requested.connect (on_view_new_game_requested);

			key_event_controller = new Gtk.EventControllerKey (window);
			key_event_controller.key_pressed.connect (on_key_released);

			game_model.start_new_game ();
			reset_milestone_data ();

			update_game_view ();
		}

		public Views.GameView get_game_view () {
			return game_view;
		}

		public bool on_key_released (uint keyval, uint keycode, Gdk.ModifierType state) {
			if(keyval == Gdk.Key.Left) {
				game_model.move(Directions.LEFT);
				update_game_view ();

				if (game_model.get_largest_tile () == next_milestone_value) {
					show_milestone ();
				}
				if (game_model.is_game_over()) {
					game_view.show_game_over_dialog ();
				}

				return true;
			}
			if(keyval == Gdk.Key.Right) {
				game_model.move(Directions.RIGHT);
				update_game_view ();

				if (game_model.get_largest_tile () == next_milestone_value) {
					show_milestone ();
				}
				if (game_model.is_game_over()) {
					game_view.show_game_over_dialog ();
				}
				return true;
			}
			if(keyval == Gdk.Key.Up) {
				game_model.move(Directions.UP);
				update_game_view ();

				if (game_model.get_largest_tile () == next_milestone_value) {
					show_milestone ();
				}
				if (game_model.is_game_over()) {
					game_view.show_game_over_dialog ();
				}
				return true;
			}
			if(keyval == Gdk.Key.Down) {
				game_model.move(Directions.DOWN);
				update_game_view ();

				if (game_model.get_largest_tile () == next_milestone_value) {
					show_milestone ();
				}
				if (game_model.is_game_over()) {
					game_view.show_game_over_dialog ();
				}
				return true;
			}
			return false;
		}

		private void show_milestone () {
			update_next_milestone_value (next_milestone_value);
			game_view.show_toast (next_milestone_message);
			update_next_milestone_message ();
		}

		private void update_game_view () {
			game_view.update_board (game_model.get_board_state ());
			game_view.update_current_score (game_model.get_current_score ());
			game_view.update_high_score (game_model.get_high_score ());
		}

		private void update_next_milestone_value (int current_value) {
			switch (current_value) {
				case 128:
					next_milestone_value = 256 ;
					break;
				case 256:
					next_milestone_value = 512 ;
					break;
				case 512:
					next_milestone_value = 1024 ;
					break;
				case 1024:
					next_milestone_value = 2048;
					break;
				case 2048:
					next_milestone_value = 4096;
					break;
				case 4096:
					next_milestone_value = 8092;
					break;
				case 8092:
					next_milestone_value = -1 ;
				 	break;
			}
		}

		private void update_next_milestone_message () {
			switch (next_milestone_value) {
				case 128:
					next_milestone_message = "128";
					break;
				case 256:
					next_milestone_message = "256";
					break;
				case 512:
					next_milestone_message = "512";
					break;
				case 1024:
					next_milestone_message = "1024";
					break;
				case 2048:
					next_milestone_message = "2048";
					break;
				case 4096:
					next_milestone_message = "4096";
					break;
				case 8092:
					next_milestone_message = "8092";
				 	break;
			}
		}

		private void reset_milestone_data () {
			next_milestone_value = 128;
			next_milestone_message = "128";
		}

		private void on_model_board_updated (int[,] board_state) {
		//	game_view.update_board (board_state);
		}

		private void on_view_new_game_requested () {
			reset_milestone_data ();
			game_model.start_new_game ();
			game_view.update_board (game_model.get_board_state ());
			game_view.update_current_score (game_model.get_current_score ());
		}
	}
}
