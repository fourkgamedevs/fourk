namespace FourK.Views {
	internal class GameView : Gtk.Box {
		private Widgets.ScoreBox high_score;
		private Widgets.ScoreBox current_score;
		private Widgets.BoardGrid board;
		private Gtk.Frame frame;

		public GameView () {
			init_properties ();
			init_board_grid ();
		}

		public void update_high_score () {

		}

		public void update_current_score () {

		}

		public void update_board (int[,] board_state ) {
			string[,] board_state_strings = new string[4,4];
			for (int r = 0; r < 4; r++) {
				for (int c = 0; c < 4; c++) {
					board_state_strings[c,r] = board_state[r,c].to_string ();
					if(board_state[r,c] == 0) {
						board_state_strings[c,r] = "";
					}
				}
			}
			board.set_board_state (board_state_strings);
		}

		private void init_properties () {
			set_vexpand (true);
			set_hexpand (true);
			set_valign (Gtk.Align.CENTER);
			set_halign (Gtk.Align.CENTER);
		}

		private void init_board_grid () {
			frame = new Gtk.Frame (null);
			frame.set_size_request (330,330);
			frame.set_vexpand (false);
			frame.set_hexpand (false);

			frame.set_valign (Gtk.Align.CENTER);
			frame.set_halign (Gtk.Align.CENTER);

			var context = frame.get_style_context ();
			context.add_class (Granite.STYLE_CLASS_CARD);

			board = new Widgets.BoardGrid ();
			frame.add (board);
			add (frame);
		}
	}
}
