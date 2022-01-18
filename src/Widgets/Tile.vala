namespace FourK.Widgets {
	internal class Tile : Gtk.Layout {
		private Gtk.Label number_label;

		public Tile () {
			set_size_request (30, 30);
			number_label = new Gtk.Label ("2");
			put (number_label, 15, 15);
		}
	}
}
