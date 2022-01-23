namespace FourK.Widgets {
	internal class GameOverDialog : Granite.MessageDialog {
		public GameOverDialog () {
			base.with_image_from_icon_name ("Game Over", "No move moves available :(", "face-heart-broken", Gtk.ButtonsType.NONE);
			 
		}
	}
}
