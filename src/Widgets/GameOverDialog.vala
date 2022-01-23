namespace FourK.Widgets {
	internal class GameOverDialog : Granite.MessageDialog {
		public GameOverDialog () {
			base.with_image_from_icon_name ("Game Over", "No move moves available :(", "face-heart-broken", Gtk.ButtonsType.NONE);
			add_button ("Quit", Gtk.ResponseType.CLOSE);
			add_button ("Back", Gtk.ResponseType.CANCEL);
			add_button ("New Game", Gtk.ResponseType.ACCEPT);
			set_default_response (Gtk.ResponseType.ACCEPT);
		}
	}
}
