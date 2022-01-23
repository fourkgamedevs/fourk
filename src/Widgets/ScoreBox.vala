namespace FourK.Widgets {
	internal class ScoreBox : Gtk.Box {
		private Gtk.Label name;
		private Gtk.Grid score_holder;
		private Gtk.Label score_label;

		public ScoreBox (string score_name) {
			init_properties ();


			name = new Gtk.Label (score_name);
			name.margin = 8;
			name.margin_bottom = 2;
			var context = name.get_style_context ();
			context.add_class (Granite.STYLE_CLASS_H3_LABEL);
			context.add_class (Granite.STYLE_CLASS_ACCENT);

			name.set_halign (Gtk.Align.START);
			name.set_valign (Gtk.Align.CENTER);
			score_label = new Gtk.Label("----");
			score_label.set_halign (Gtk.Align.CENTER);
			score_label.margin = (8);
			score_label.margin_top = (2);
			context = score_label.get_style_context ();
			context.add_class (Granite.STYLE_CLASS_H2_LABEL);
			//context.add_class (Granite.STYLE_CLASS_ACCENT);

			score_holder = new Gtk.Grid ();
			score_holder.add(score_label);

			score_holder.set_valign (Gtk.Align.CENTER);
			score_holder.set_halign (Gtk.Align.END);
			score_holder.set_hexpand (true);
			score_holder.set_vexpand (true);
			var sep = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);
			sep.set_vexpand (true);
			add (name);
			add (sep);
			add (score_holder);

		}

		public void set_score_label(string score) {
			score_label.set_label(score);
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
