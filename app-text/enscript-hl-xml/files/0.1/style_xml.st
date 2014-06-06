
state style_xml
{
	BEGIN {
		call (default_faces);
		define_color ("red4", 139, 0, 0);
		define_color ("blue4", 35, 35, 220);
		define_color ("MediumBlue", 0, 0, 205);
		define_color ("DarkGreen", 0, 100, 0);
		define_color ("Bordeaux", 153, 51, 102);
		define_color ("user1", 145, 0, 50);
		face_bold           = make_face (bold_font, 1, 0);
		face_italic         = make_face (italic_font, 0, 1);
		face_bold_italic    = make_face (bold_italic_font, 1, 1);
		face_function_name  = make_face (font, 0, 0);
		face_variable_name  = make_face (font, 0, 0);
		face_string         = make_face (font, 0, 0);
		face_builtin        = make_face (font, 0, 0);
		face_comment        = make_face (italic_font, 0, 1);

		/* These are the only faces which are highlighted. */
		if (color)
		{
			face_keyword    = make_face (font, 0, 0);
			face_type       = make_face (font, 0, 0);
			face_reference  = make_face (font, 0, 0);

			/* Set colors. */
			face_bold[fg_color] =		language_color ("user1");
			face_italic[fg_color] =		language_color ("black");
			face_bold_italic[fg_color] =	language_color ("black");
			face_comment[fg_color] =	language_color ("red4");
			face_function_name[fg_color] =	language_color ("red");
			face_variable_name[fg_color] =	language_color ("blue4");
			face_keyword[fg_color] =	language_color ("MediumBlue");
			face_string[fg_color] =		language_color ("DarkGreen");
			face_reference[fg_color] =	language_color ("Aquamarine");
			face_builtin[fg_color] =	language_color ("purple");
			face_type[fg_color] =		language_color ("Bordeaux");
		}
		else
		{
			face_keyword    = make_face (bold_font, 1, 0);
			face_type       = make_face (bold_font, 1, 0);
			face_reference  = make_face (bold_font, 1, 0);
		}

		return;
	}
}


/*
Local variables:
mode: c
End:
*/
