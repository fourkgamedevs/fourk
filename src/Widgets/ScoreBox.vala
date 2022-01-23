namespace FourK.Widgets {
	internal class ScoreBox : Gtk.Box {
		private Gtk.Label name;
		private Gtk.Grid score_holder;

		public ScoreBox () {
			init_properties ();

			name = new Gtk.Label ("Score Name");
			score_holder = new Gtk.Grid ();
			score_holder.add(new Gtk.Label("1 0 2 4"));
			add (name);
			add (score_holder);

		}

		private void init_properties () {
			var context = get_style_context ();
			context.add_class (Granite.STYLE_CLASS_CARD);
			context.add_class (Granite.STYLE_CLASS_ROUNDED);

			orientation = Gtk.Orientation.VERTICAL;

			set_margin_bottom (4);
			set_margin_top (4);
			set_margin_right (4);
			set_margin_left (4);
			set_valign (Gtk.Align.CENTER);
			set_halign (Gtk.Align.CENTER);
			set_vexpand (false);
			set_hexpand (true);

			set_size_request (120, 80);
		}
	}
}
