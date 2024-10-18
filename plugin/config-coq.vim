call minpac#add('ms-jpq/coq_nvim', {'branch': 'coq', 'do': 'packloadall! | COQdeps'})
call minpac#add('ms-jpq/coq.artifacts', {'branch': 'artifacts'})
call minpac#add('ms-jpq/coq.thirdparty', {'branch': '3p'})

let g:coq_settings = {'auto_start': 'shut-up'}
