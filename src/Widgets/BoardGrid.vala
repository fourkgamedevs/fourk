namespace FourK.Widgets {
	internal class BoardGrid : Gtk.Grid {
		private Widgets.Tile tile;
		public BoardGrid () {
			tile = new Tile ();
			add (tile);
		}

		private void init_board () {

		}
	}
}
