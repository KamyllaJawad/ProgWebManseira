async function conectar() {
    if (req.session.usuario) {
        const usuario = await db_aprendizagem_adaptativa.usuario()
        res.render('telaConsultaProfessor', { usuario })
    } else res.render('error')
}

async function listarProfessor() {
    const conexao = await conectar()
    const [linhas] = await conexao.query('select * from usuarios;')
    return linhas
}

async function inserirProfessor(usuario) {
    const conexao = await conectar()
    const sql = 'insert into usuarios (no_usuario, de_usu_login, nr_senha) values (?,?,?);'
    const dados = [usuario.no_usuario, usuario.de_usu_login, usuario.nr_senha]
    return await conexao.query(sql, dados)
}

async function alterarProfessor(usuario) {
    const conexao = await conectar()
    const sql = 'update usuarios set no_usuario=?, de_usu_login=?, nr_senha=? where cd_usuario=?;'
    const dados = [usuario.no_usuario, usuario.de_usu_login, usuario.nr_senha, usuario.cd_usuario]
    return await conexao.query(sql, dados)
}

async function deletarProfessor(cd_usuario) {
    const conexao = await conectar()
    const sql = 'delete from usuarios where cd_usuario=?;'
    const dados = [cd_usuario]
    return await conexao.query(sql, dados)
}

module.exports = { listarProfessor, inserirProfessor, alterarProfessor, deletarProfessor }