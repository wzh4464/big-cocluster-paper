# 基本设置
$pdf_mode = 1;          # 使用 pdflatex
$bibtex_use = 2;        # 使用 biber
$clean_ext = "aux fdb_latexmk fls log";  # 清理扩展

# 外部文档依赖规则
add_cus_dep('tex', 'aux', 0, 'makeexternaldocument');

sub makeexternaldocument {
    if (!($root_filename eq $_[0])) {
        print "正在编译外部文档: $_[0].tex -> $_[0].aux\n";
        my $ret = system("latexmk -cd -pdf \"$_[0]\"");
        if ($ret != 0) {
            print "错误：无法编译 $_[0].tex\n";
        }
        return $ret;
    }
    return 0;
}