namespace FourK.Views {
	internal class GameView : Gtk.Box {
		private Widgets.ScoreBox high_score;
		private Widgets.ScoreBox current_score;
		private Gtk.Box scores_holder;

		private Widgets.BoardGrid board;
		private Gtk.Frame frame;

		private Gtk.Window parent_window;

		public signal void new_game_requested ();
		public signal void quit_game_requested ();

		public GameView (Gtk.Window parent_window) {
			this.parent_window = parent_window;
			init_properties ();
			init_board_grid ();
			scores_holder = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 8);
			scores_holder.set_vexpand (false);
			high_score = new Widgets.ScoreBox ("High Score");
			current_score = new Widgets.ScoreBox ("Score");
			scores_holder.add (high_score);
			scores_holder.add (current_score);
			add (scores_holder);
			var sep = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
			sep.set_vexpand (true);
			add (sep);
			add (frame);
		}

		public void update_high_score (int score) {
			high_score.set_score_label (score.to_string ());
		}

		public void update_current_score (int score) {
			current_score.set_score_label (score.to_string ());
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

		public void show_game_over_dialog () {
			Widgets.GameOverDialog game_over_dialog = new Widgets.GameOverDialog ();
			game_over_dialog.transient_for = parent_window;


			int response_id = game_over_dialog.run ();
			if (response_id == Gtk.ResponseType.CANCEL) {
				game_over_dialog.destroy ();
			} else if (response_id == Gtk.ResponseType.ACCEPT) {
				game_over_dialog.destroy ();
				new_game_requested ();
			} else if (response_id == Gtk.ResponseType.CLOSE) {
				game_over_dialog.destroy ();
				quit_game_requested ();
			}
		}

		private void init_properties () {
			set_spacing(24);
			set_vexpand (true);
			set_hexpand (true);
			set_valign (Gtk.Align.CENTER);
			set_halign (Gtk.Align.CENTER);
			orientation = Gtk.Orientation.VERTICAL;
		}

		private void init_board_grid () {
			frame = new Gtk.Frame (null);
			frame.set_size_request (330,330);
			frame.set_vexpand (false);
			frame.set_hexpand (false);
			set_valign (Gtk.Align.CENTER);
			set_halign (Gtk.Align.CENTER);


			frame.set_valign (Gtk.Align.CENTER);
			frame.set_halign (Gtk.Align.CENTER);

			var context = frame.get_style_context ();
			context.add_class (Granite.STYLE_CLASS_CARD);
			context.add_class (Granite.STYLE_CLASS_ROUNDED);

			board = new Widgets.BoardGrid ();
			frame.add (board);
		}
	}
}
