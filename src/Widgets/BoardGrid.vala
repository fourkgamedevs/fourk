namespace FourK.Widgets {
	internal class BoardGrid : Gtk.Grid {
		private Widgets.Tile[,] board_tiles;
		public BoardGrid () {
			init_properties ();
			init_board ();
		}

		public void set_board_state (string[,] board_state) {
			for (int r = 0; r < 4; r++) {
				for (int c = 0; c < 4; c++) {
					board_tiles[c,r].set_number (board_state[r,c]);
				}
			}
		}

		private void init_board () {
			board_tiles = new Widgets.Tile[4,4];
			for (int r = 0; r < 4; r++) {
				for (int c = 0; c < 4; c++) {
					board_tiles[c,r] = new Widgets.Tile ();
					board_tiles[c,r].set_number ("");
					attach (board_tiles[c,r], c, r);
				}
			}
		}

		private void init_properties () {
			set_column_spacing (8);
			set_row_spacing (8);
			set_margin_bottom (4);
			set_margin_top (4);
			set_margin_right (4);
			set_margin_left (4);
			set_valign (Gtk.Align.CENTER);
			set_halign (Gtk.Align.CENTER);

			set_size_request (300, 300);
		}
	}
}
