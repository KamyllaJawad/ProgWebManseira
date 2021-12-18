async function conectar() {
    if (global.connection && global.state != 'disconnected') {
        return global.connection
    }

    const mysql = require('mysql2/promise')
    const strCon = 'mysql://root:root@localhost:3306/db_aprendizagem_adaptativa'
    const conexao = await mysql.createConnection(strCon)

    global.connection = conexao
    return conexao
}

//BUSCAS USUARIOS E DISCIPLINAS

async function buscarUsuario(usuario, senha, tipoUsu) {
    const conexao = await conectar()
    const sql = 'select * from usuarios where de_usu_login=? and nr_senha=? and cd_tipo_usu=?;'
    const [linhas] = await conexao.query(sql, [usuario, senha, tipoUsu])
    return linhas
}

async function buscarDisciplina(nomeDisciplina) {
    const conexao = await conectar()
    const sql = 'select * from disciplinas where cd_disciplina=?;'
    const [linhas] = await conexao.query(sql, nomeDisciplina)
    return linhas
}

//CRUD USUARIO

async function incluirUsuario(dados) {
    const conexao = await conectar()
    const sql = 'insert into usuarios (no_usuario, de_usu_login, nr_senha, cd_tipo_usu) values (?,?,?,?);'
    return await conexao.query(sql, dados)
}

async function listarUsuarios() {
    const conexao = await conectar()
    const sql = 'select * from usuarios order by no_usuario'
    const [linhas] = await conexao.query(sql)
    return linhas
}

async function atualizarUsuarios(dados) {
    const conexao = await conectar()
    const sql = 'update usuarios set no_usuario, de_usu_login, nr_senha, cd_tipo_usu where cd_usuario=?;'
    return await conexao.query(sql, dados)
}


async function excluirUsuario(id) {
    const conexao = await conectar()
    const sql = 'delete from usuarios where cd_usuario=?;'
    return await conexao.query(sql, [id])
}

//CRUD  DISCIPLINA
async function incluirDisciplina(dados) {
    const conexao = await conectar()
    const sql = 'insert into disciplinas (de_disciplina) values (?);'
    return await conexao.query(sql, dados)
}

async function listarDisciplina() {
    const conexao = await conectar()
    const sql = 'select * from disciplinas order by de_disciplina'
    const [linhas] = await conexao.query(sql)
    return linhas
}

async function atualizarDisciplina(dados) {
    const conexao = await conectar()
    const sql = 'update disciplinas set de_disciplina where cd_disciplina=?;'
    return await conexao.query(sql, dados)
}


async function excluirDisciplina(id) {
    const conexao = await conectar()
    const sql = 'delete from disciplinas where cd_disciplina=?;'
    return await conexao.query(sql, [id])
}

module.exports = { buscarDisciplina, buscarUsuario, incluirDisciplina, incluirUsuario, listarDisciplina, listarUsuarios, atualizarDisciplina, atualizarUsuarios, excluirDisciplina, excluirUsuario }