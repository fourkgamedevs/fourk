namespace FourK.Controllers {
	internal class Game : GLib.Object {
		private Views.GameView game_view;
		private Models.Game game_model;
		private Gtk.EventControllerKey key_event_controller;

		public Game (Hdy.ApplicationWindow window) {
			game_view = new Views.GameView ();
			game_model = new Models.Game ();
			game_model.board_updated.connect (on_model_board_updated);
			key_event_controller = new Gtk.EventControllerKey (window);
			key_event_controller.key_pressed.connect (on_key_released);
			game_model.start_new_game ();
			int[,] board_state = game_model.get_board_state ();
			game_view.update_board (board_state);
			//test_board_update ();
		}

		public Views.GameView get_game_view () {
			return game_view;
		}

		public bool on_key_released (uint keyval, uint keycode, Gdk.ModifierType state) {
			if(keyval == Gdk.Key.Left) {
				game_model.move(Directions.LEFT);
				game_view.update_board (game_model.get_board_state ());
				game_view.update_current_score (game_model.get_current_score ());
				return true;
			}
			if(keyval == Gdk.Key.Right) {
				game_model.move(Directions.RIGHT);
				game_view.update_board (game_model.get_board_state ());
				game_view.update_current_score (game_model.get_current_score ());
				return true;
			}
			if(keyval == Gdk.Key.Up) {
				game_model.move(Directions.UP);
				game_view.update_board (game_model.get_board_state ());
				game_view.update_current_score (game_model.get_current_score ());
				return true;
			}
			if(keyval == Gdk.Key.Down) {
				game_model.move(Directions.DOWN);
				game_view.update_board (game_model.get_board_state ());
				game_view.update_current_score (game_model.get_current_score ());
				return true;
			}
			return false;
		}

		private void on_model_board_updated (int[,] board_state) {
		//	game_view.update_board (board_state);
		}


	}
}
