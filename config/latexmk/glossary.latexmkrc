add_cus_dep('acn', 'acr', 0, 'makeglossaries');
add_cus_dep('glo', 'gls', 0, 'makeglossaries');

sub makeglossaries {
    my ($base_name, $path) = fileparse( $_[0] );
    my @args = ( "-q" ,"-d", $path, $base_name );
    return system "makeglossaries", @args;
}

push @generated_exts, "cb";
push @generated_exts, "cb2";
push @generated_exts, "spl";
push @generated_exts, "nav";
push @generated_exts, "snm";
push @generated_exts, "tdo";
push @generated_exts, "nmo";
push @generated_exts, "brf";
push @generated_exts, "nlg";
push @generated_exts, "nlo";
push @generated_exts, "nls";
push @generated_exts, "synctex.gz";
push @generated_exts, "synctex.gz(busy)";
push @generated_exts, "run.xml";
push @generated_exts, "loa";
push @generated_exts, "tns";
push @generated_exts, "lol";
push @generated_exts, "glo";
push @generated_exts, "glsdefs";
push @generated_exts, "ist";
push @generated_exts, "glg";
push @generated_exts, "gls";
