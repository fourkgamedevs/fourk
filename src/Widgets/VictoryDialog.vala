namespace FourK.Widgets {
	internal class VictoryDialog : Granite.MessageDialog {
		public VictoryDialog () {
			base.with_image_from_icon_name ("Congratulations!", "You Reached the mythical 4096 tile!", "face-heart", Gtk.ButtonsType.NONE);
			add_button ("Quit", Gtk.ResponseType.CLOSE);
			add_button ("Continue Playing", Gtk.ResponseType.ACCEPT);
			set_default_response (Gtk.ResponseType.ACCEPT);
		}
	}
}
