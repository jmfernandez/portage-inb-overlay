/**
 * Name: xml
 * Description: eXtensible Markup Language XML.
 * Author: José María Fernández González <jmfernandez@cnb.uam.es>
 */

state xml extends HighlightEntry
{
	/* Comments */
	/<!\-\-/ {
		comment_face (true);
		language_print ($0);
		call (xml_comment);
		comment_face (false);
	}
	
	/* CDATA */
	/<!\[CDATA\[/ {
		reference_face (true);
		language_print ($0);
		call (xml_cdata);
		reference_face (false);
	}
	/* Processor instructions */
  /<\?xml[\t ]/ {
    function_name_face (true);
    language_print ($0);
    call (xml_attrs);
    function_name_face (false);
  }
  /<\?/ {
    builtin_face (true);
    language_print ($0);
    call (xml_xml);
    builtin_face (false);
  }
  /</ {
    keyword_face (true);
    language_print ($0);
    call (xml_tag);
    keyword_face (false);
  }
  /&/ {
    keyword_face (true);
    language_print ($0);
    call (xml_entity);
    keyword_face (false);
  }
}

state xml_comment extends Highlight
{
	/\-\->/ {
		language_print ($0);
		return;
	}
}

state xml_cdata extends Highlight
{
	/\]\]>/ {
		language_print ($0);
		return;
	}
}

state xml_tag extends Highlight
{
  /[^\n\t \'\"=>\/\?:]+:/ {
    bold (true);
    language_print ($0);
    bold (false);
  }
  /[^\n\t \'\"=>\/\?:]+/ {
    type_face (true);
    language_print ($0);
    type_face (false);
    call (xml_attrs);
    return;
  }
}

state xml_xml extends Highlight
{
  /[^\n\t \'\"=>\/]+/ {
    language_print ($0);
    call (xml_attrs);
    return;
  }
}

state xml_attrs extends Highlight
{
  />/ {
    language_print ($0);
    return;
  }
  /\"/ {
    string_face (true);
    language_print ($0);
    call (c_string);
    string_face (false);
  }
  /[\']/ {
    string_face (true);
    language_print ($0);
    call (xml_string);
    string_face (false);
  }
  /[^\n\t \'\"=>\/\?:]+:/ {
    bold (true);
    language_print ($0);
    bold (false);
  }
  /[^\n\t \'\"=>\/\?:]+/ {
    variable_name_face (true);
    language_print ($0);
    variable_name_face (false);
  }
  /=/ {
    language_print ($0);
  }
}

state xml_string extends Highlight
{
	/[\']/ {
		language_print ($0);
		return;
	}
}

state xml_entity extends Highlight
{
  /;/ {
    language_print ($0);
    return;
  }
}



/*
Local variables:
mode: c
End:
*/
