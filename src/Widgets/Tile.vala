namespace FourK.Widgets {
	internal class Tile : Gtk.Frame {
		private Gtk.Label number_label;

		public Tile () {
			init_properties ();
			init_label ();
		}

		public void set_number (string number) {
			var context = get_style_context ();

			if (number == "") {
				context.remove_class (Granite.STYLE_CLASS_CARD);
				context.remove_class (Granite.STYLE_CLASS_ROUNDED);

			} else {
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
			lctx.add_class (Granite.STYLE_CLASS_ACCENT);
			lctx.add_class (Granite.STYLE_CLASS_H3_LABEL);

			add (number_label);
		}
	}
}
