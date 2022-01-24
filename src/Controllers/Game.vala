namespace FourK.Controllers {
	internal class Game : GLib.Object {
		private Views.GameView game_view;
		private Models.Game game_model;
		private Gtk.EventControllerKey key_event_controller;

		private int last_largest_value;

		public Game (Hdy.ApplicationWindow window) {
			game_view = new Views.GameView (window);
			game_model = new Models.Game ();

			game_model.board_updated.connect (on_model_board_updated);
			game_view.new_game_requested.connect (on_view_new_game_requested);

			key_event_controller = new Gtk.EventControllerKey (window);
			key_event_controller.key_pressed.connect (on_key_released);
			game_model.start_new_game ();
			int[,] board_state = game_model.get_board_state ();
			game_view.update_board (board_state);
		}

		public Views.GameView get_game_view () {
			return game_view;
		}

		public bool on_key_released (uint keyval, uint keycode, Gdk.ModifierType state) {
			if(keyval == Gdk.Key.Left) {
				game_model.move(Directions.LEFT);
				game_view.update_board (game_model.get_board_state ());
				game_view.update_current_score (game_model.get_current_score ());
				game_view.update_high_score (game_model.get_high_score ());
				if (game_model.get_larget_tile () == 64 && last_largest_value != game_model.get_larget_tile ()) {
					last_largest_value = 64;
					game_view.show_toast ("64 Reached!");
				}
				if (game_model.is_game_over()) {
					game_view.show_game_over_dialog ();
				}

				return true;
			}
			if(keyval == Gdk.Key.Right) {
				game_model.move(Directions.RIGHT);
				game_view.update_board (game_model.get_board_state ());
				game_view.update_current_score (game_model.get_current_score ());
				game_view.update_high_score (game_model.get_high_score ());
				if (game_model.get_larget_tile () == 64 && last_largest_value != game_model.get_larget_tile ()) {
					last_largest_value = 64;
					game_view.show_toast ("64 Reached!");
				}
				if (game_model.is_game_over()) {
					game_view.show_game_over_dialog ();
				}
				return true;
			}
			if(keyval == Gdk.Key.Up) {
				game_model.move(Directions.UP);
				game_view.update_board (game_model.get_board_state ());
				game_view.update_current_score (game_model.get_current_score ());
				game_view.update_high_score (game_model.get_high_score ());
				if (game_model.get_larget_tile () == 64 && last_largest_value != game_model.get_larget_tile ()) {
					last_largest_value = 64;
					game_view.show_toast ("64 Reached!");
				}
				if (game_model.is_game_over()) {
					game_view.show_game_over_dialog ();
				}
				return true;
			}
			if(keyval == Gdk.Key.Down) {
				game_model.move(Directions.DOWN);
				game_view.update_board (game_model.get_board_state ());
				game_view.update_current_score (game_model.get_current_score ());
				game_view.update_high_score (game_model.get_high_score ());
				if (game_model.get_larget_tile () == 64 && last_largest_value != game_model.get_larget_tile ()) {
					last_largest_value = 64;
					game_view.show_toast ("64 Reached!");
				}
				if (game_model.is_game_over()) {
					game_view.show_game_over_dialog ();
				}
				return true;
			}
			return false;
		}

		private void on_model_board_updated (int[,] board_state) {
		//	game_view.update_board (board_state);
		}

		private void on_view_new_game_requested () {
			game_model.start_new_game ();
			game_view.update_board (game_model.get_board_state ());
			game_view.update_current_score (game_model.get_current_score ());
			last_largest_value = 0;
		}


	}
}
