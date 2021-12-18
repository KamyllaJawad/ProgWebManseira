var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('index', { title: 'Manseirismo' });
});

router.get('/login', function(req, res, next) {
    res.render('login');
});

router.post('/login', async(req, res) => {
    //pegar os dados do formulário
    const usuarioForm = req.body.txtUsuario
    const senhaForm = req.body.pswSenha
    const tipoUsuForm = parseInt(req.body.tipoUsuario)
console.log(usuarioForm, senhaForm, tipoUsuForm)
    //verificar se os dados do formulário estão no BD
    const linhas = await global.banco.buscarUsuario(usuarioForm, senhaForm, tipoUsuForm)

    //se o usuário existir, mostrar a página de menu
    let usuarioValido = false
    if (linhas.length > 0) {
        //se o usuário não existir, mostrar a página de erro
        global.usuarioValido = usuarioForm

        if (tipoUsuForm == 1) {
            res.render('telaAcessoAluno')
        }
        else if (tipoUsuForm == 2) {
            res.render('telaAcessoProfessor')
        }
    }
    else res.render('error')
});

//PARTE DE ROTAS DE USUARIOS
router.get('/telaUsuarioCadastro', async(req, res) => {
    console.log(global.usuarioValido)
    if (global.usuarioValido) {
        res.render('telaUsuarioCadastro')
    } else res.render('error')
})

router.post('/telaUsuarioCadastro', async(req, res) => {
    if (global.usuarioValido) {
        const nome = req.body.inputName
        const login = req.body.inputLogin
        const senha = req.body.inputPassword
        const tipo = parseInt(req.body.inputSelected)

        await global.banco.incluirUsuario([nome, login, senha, tipo])
        res.redirect('/telaUsuarioConsulta')
    } else res.render('error')
})

router.get('/telaUsuarioConsulta', async(req, res) => {
    if (global.usuarioValido) {
        const usuarios = await global.banco.listarUsuarios()
        res.render('telaUsuarioConsulta', { usuarios }) // manda mostrar a pagina telaAlunoConsulta.HTML
    } else res.render('error')
})

router.get('/telaUsuarioAtualizar', async(req, res) => {
    if (global.usuarioValido) {
        const nome = req.body.inputName
        const login = req.body.inputLogin
        const senha = req.body.inputPassword
        const tipo = parseInt(req.body.inputSelected)

        await global.banco.atualizarUsuarios([nome, login, senha, tipo])
        res.redirect('/telaUsuarioConsulta')
    } else res.render('error')
})

//PARTE DE ROTAS DE DISCIPLINAS

router.get('/telaDisciplinaCadastro', async(req, res) => {
    console.log(global.usuarioValido)
    if (global.usuarioValido) {
        res.render('telaDisciplinaCadastro')
    } else res.render('error')
})

router.post('/telaDisciplinaCadastro', async(req, res) => {
    if (global.usuarioValido) {
        const nomeDisciplina = req.body.inputName
        await global.banco.incluirDisciplina([nomeDisciplina])
        res.redirect('/telaDisciplinaConsulta')
    } else res.render('error')
})

router.get('/telaDisciplinaConsulta', async(req, res) => {
    if (global.usuarioValido) {
        const disciplinas = await global.banco.listarDisciplina()
        res.render('telaDisciplinaConsulta', { disciplinas }) // manda mostrar a pagina telaAlunoConsulta.HTML
    } else res.render('error')
})

router.get('/telaDisciplinaAtualizar', async(req, res) => {
    if (global.usuarioValido) {
        const nomeDisciplina = req.body.inputName
        await global.banco.atualizarDisciplina([nomeDisciplina])
        res.redirect('/telaDisciplinaConsulta')
    } else res.render('error')
})

module.exports = router;