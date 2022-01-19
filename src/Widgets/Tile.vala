namespace FourK.Widgets {
	internal class Tile : Gtk.Frame {
		private Gtk.Label number_label;
		private Gtk.StyleContext context;

		public Tile () {
			context = get_style_context ();

			init_properties ();
			init_label ();
		}

		public void set_number (string number) {
			context.remove_class (Granite.STYLE_CLASS_CARD);
			context.remove_class (Granite.STYLE_CLASS_ROUNDED);
			context.remove_class(number_label.get_text ());
			context.add_class("empty");

			if (number != "") {
				context.remove_class("empty");
				context.add_class (number);
				context.add_class (Granite.STYLE_CLASS_CARD);
				context.add_class (Granite.STYLE_CLASS_ROUNDED);
			}
			number_label.set_text (number);
		}

		private void init_properties () {
			set_size_request (75, 75);
			set_valign (Gtk.Align.CENTER);
			set_halign (Gtk.Align.CENTER);
			set_hexpand (true);
			set_vexpand (true);
		}

		private void init_label () {
			number_label = new Gtk.Label ("");
			var lctx = number_label.get_style_context ();
			lctx.add_class ("TileText");
			lctx.add_class (Granite.STYLE_CLASS_H3_LABEL);

			add (number_label);
		}
	}
}
