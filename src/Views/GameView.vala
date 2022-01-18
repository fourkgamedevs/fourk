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
