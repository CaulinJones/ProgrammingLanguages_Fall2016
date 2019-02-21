#include <setjmp.h>
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include "a9.h"

void *envrr_emptyr__m__env() {
envr* _data = (envr*)malloc(sizeof(envr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _emptyr__m__env_envr;
  return (void *)_data;
}

void *envrr_extendr__m__env(void *ar__ex__, void *envr__ex__) {
envr* _data = (envr*)malloc(sizeof(envr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _extendr__m__env_envr;
  _data->u._extendr__m__env._ar__ex__ = ar__ex__;
  _data->u._extendr__m__env._envr__ex__ = envr__ex__;
  return (void *)_data;
}

void *closr_closure(void *bodyr__ex__, void *envr__ex__) {
clos* _data = (clos*)malloc(sizeof(clos));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _closure_clos;
  _data->u._closure._bodyr__ex__ = bodyr__ex__;
  _data->u._closure._envr__ex__ = envr__ex__;
  return (void *)_data;
}

void *ktr_emptyr__m__k(void *dismount) {
kt* _data = (kt*)malloc(sizeof(kt));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _emptyr__m__k_kt;
  _data->u._emptyr__m__k._dismount = dismount;
  return (void *)_data;
}

void *ktr_r__t__r__m__inr__m__k(void *yr__ex__, void *kr__ex__) {
kt* _data = (kt*)malloc(sizeof(kt));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _r__t__r__m__inr__m__k_kt;
  _data->u._r__t__r__m__inr__m__k._yr__ex__ = yr__ex__;
  _data->u._r__t__r__m__inr__m__k._kr__ex__ = kr__ex__;
  return (void *)_data;
}

void *ktr_r__t__r__m__outr__m__k(void *xr__ex__, void *envr__ex__, void *kr__ex__) {
kt* _data = (kt*)malloc(sizeof(kt));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _r__t__r__m__outr__m__k_kt;
  _data->u._r__t__r__m__outr__m__k._xr__ex__ = xr__ex__;
  _data->u._r__t__r__m__outr__m__k._envr__ex__ = envr__ex__;
  _data->u._r__t__r__m__outr__m__k._kr__ex__ = kr__ex__;
  return (void *)_data;
}

void *ktr_sr1r__m__inr__m__k(void *kr__ex__) {
kt* _data = (kt*)malloc(sizeof(kt));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _sr1r__m__inr__m__k_kt;
  _data->u._sr1r__m__inr__m__k._kr__ex__ = kr__ex__;
  return (void *)_data;
}

void *ktr_zrr__m__inr__m__k(void *kr__ex__) {
kt* _data = (kt*)malloc(sizeof(kt));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _zrr__m__inr__m__k_kt;
  _data->u._zrr__m__inr__m__k._kr__ex__ = kr__ex__;
  return (void *)_data;
}

void *ktr_ifr__m__inr__m__k(void *cr__ex__, void *ar__ex__, void *envr__ex__, void *kr__ex__) {
kt* _data = (kt*)malloc(sizeof(kt));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _ifr__m__inr__m__k_kt;
  _data->u._ifr__m__inr__m__k._cr__ex__ = cr__ex__;
  _data->u._ifr__m__inr__m__k._ar__ex__ = ar__ex__;
  _data->u._ifr__m__inr__m__k._envr__ex__ = envr__ex__;
  _data->u._ifr__m__inr__m__k._kr__ex__ = kr__ex__;
  return (void *)_data;
}

void *ktr_thrr__m__outr__m__k(void *er__ex__, void *envr__ex__) {
kt* _data = (kt*)malloc(sizeof(kt));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _thrr__m__outr__m__k_kt;
  _data->u._thrr__m__outr__m__k._er__ex__ = er__ex__;
  _data->u._thrr__m__outr__m__k._envr__ex__ = envr__ex__;
  return (void *)_data;
}

void *ktr_thrr__m__inr__m__k(void *vr__ex__) {
kt* _data = (kt*)malloc(sizeof(kt));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _thrr__m__inr__m__k_kt;
  _data->u._thrr__m__inr__m__k._vr__ex__ = vr__ex__;
  return (void *)_data;
}

void *ktr_letr__m__inr__m__k(void *br__ex__, void *envr__ex__, void *kr__ex__) {
kt* _data = (kt*)malloc(sizeof(kt));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _letr__m__inr__m__k_kt;
  _data->u._letr__m__inr__m__k._br__ex__ = br__ex__;
  _data->u._letr__m__inr__m__k._envr__ex__ = envr__ex__;
  _data->u._letr__m__inr__m__k._kr__ex__ = kr__ex__;
  return (void *)_data;
}

void *ktr_appr__m__inr__m__k(void *cr__ex__, void *kr__ex__) {
kt* _data = (kt*)malloc(sizeof(kt));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _appr__m__inr__m__k_kt;
  _data->u._appr__m__inr__m__k._cr__ex__ = cr__ex__;
  _data->u._appr__m__inr__m__k._kr__ex__ = kr__ex__;
  return (void *)_data;
}

void *ktr_appr__m__outr__m__k(void *ranr__ex__, void *envr__ex__, void *kr__ex__) {
kt* _data = (kt*)malloc(sizeof(kt));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _appr__m__outr__m__k_kt;
  _data->u._appr__m__outr__m__k._ranr__ex__ = ranr__ex__;
  _data->u._appr__m__outr__m__k._envr__ex__ = envr__ex__;
  _data->u._appr__m__outr__m__k._kr__ex__ = kr__ex__;
  return (void *)_data;
}

void *exprr_const(void *cexp) {
expr* _data = (expr*)malloc(sizeof(expr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _const_expr;
  _data->u._const._cexp = cexp;
  return (void *)_data;
}

void *exprr_var(void *n) {
expr* _data = (expr*)malloc(sizeof(expr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _var_expr;
  _data->u._var._n = n;
  return (void *)_data;
}

void *exprr_if(void *test, void *conseq, void *alt) {
expr* _data = (expr*)malloc(sizeof(expr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _if_expr;
  _data->u._if._test = test;
  _data->u._if._conseq = conseq;
  _data->u._if._alt = alt;
  return (void *)_data;
}

void *exprr_mult(void *nexpr1, void *nexpr2) {
expr* _data = (expr*)malloc(sizeof(expr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _mult_expr;
  _data->u._mult._nexpr1 = nexpr1;
  _data->u._mult._nexpr2 = nexpr2;
  return (void *)_data;
}

void *exprr_subr1(void *nexp) {
expr* _data = (expr*)malloc(sizeof(expr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _subr1_expr;
  _data->u._subr1._nexp = nexp;
  return (void *)_data;
}

void *exprr_zero(void *nexp) {
expr* _data = (expr*)malloc(sizeof(expr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _zero_expr;
  _data->u._zero._nexp = nexp;
  return (void *)_data;
}

void *exprr_letcc(void *body) {
expr* _data = (expr*)malloc(sizeof(expr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _letcc_expr;
  _data->u._letcc._body = body;
  return (void *)_data;
}

void *exprr_throw(void *kexp, void *vexp) {
expr* _data = (expr*)malloc(sizeof(expr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _throw_expr;
  _data->u._throw._kexp = kexp;
  _data->u._throw._vexp = vexp;
  return (void *)_data;
}

void *exprr_let(void *exp, void *body) {
expr* _data = (expr*)malloc(sizeof(expr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _let_expr;
  _data->u._let._exp = exp;
  _data->u._let._body = body;
  return (void *)_data;
}

void *exprr_lambda(void *body) {
expr* _data = (expr*)malloc(sizeof(expr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _lambda_expr;
  _data->u._lambda._body = body;
  return (void *)_data;
}

void *exprr_app(void *rator, void *rand) {
expr* _data = (expr*)malloc(sizeof(expr));
if(!_data) {
  fprintf(stderr, "Out of memory\n");
  exit(1);
}
  _data->tag = _app_expr;
  _data->u._app._rator = rator;
  _data->u._app._rand = rand;
  return (void *)_data;
}

int main()
{
exprr__ex__ = (void *)exprr_let(exprr_lambda(exprr_lambda(exprr_if(exprr_zero(exprr_var((void *)0)),exprr_const((void *)1),exprr_mult(exprr_var((void *)0),exprr_app(exprr_app(exprr_var((void *)1),exprr_var((void *)1)),exprr_subr1(exprr_var((void *)0))))))),exprr_mult(exprr_letcc(exprr_app(exprr_app(exprr_var((void *)1),exprr_var((void *)1)),exprr_throw(exprr_var((void *)0),exprr_app(exprr_app(exprr_var((void *)1),exprr_var((void *)1)),exprr_const((void *)4))))),exprr_const((void *)5)));
envr__m__cps = (void *)envrr_emptyr__m__env();
pc = &valuer__m__ofr__m__cps;
mount_tram();
printf("Please be 120!!: %d\n", (int)v);}

void applyr__m__closure()
{
clos* _c = (clos*)clr__ex__;
switch (_c->tag) {
case _closure_clos: {
void *bodyr__ex__ = _c->u._closure._bodyr__ex__;
void *envr__ex__ = _c->u._closure._envr__ex__;
k = (void *)ckr__ex__;
exprr__ex__ = (void *)bodyr__ex__;
envr__m__cps = (void *)envrr_extendr__m__env(cy,envr__ex__);
pc = &valuer__m__ofr__m__cps;
break; }
}
}

void applyr__m__env()
{
envr* _c = (envr*)envrr__ex__;
switch (_c->tag) {
case _emptyr__m__env_envr: {
fprintf(stderr, "Unbound Identifier");
 exit(1);
break; }
case _extendr__m__env_envr: {
void *ar__ex__ = _c->u._extendr__m__env._ar__ex__;
void *envr__ex__ = _c->u._extendr__m__env._envr__ex__;
if((ey == 0)) {
  akr__ex__ = (void *)ekr__ex__;
v = (void *)ar__ex__;
pc = &applyr__m__k;

} else {
  envrr__ex__ = (void *)envr__ex__;
ey = (void *)(void *)((int)ey - 1);
pc = &applyr__m__env;

}
break; }
}
}

void applyr__m__k()
{
kt* _c = (kt*)akr__ex__;
switch (_c->tag) {
case _emptyr__m__k_kt: {
void *dismount = _c->u._emptyr__m__k._dismount;
_trstr *trstr = (_trstr *)dismount;
longjmp(*trstr->jmpbuf, 1);
break; }
case _r__t__r__m__inr__m__k_kt: {
void *yr__ex__ = _c->u._r__t__r__m__inr__m__k._yr__ex__;
void *kr__ex__ = _c->u._r__t__r__m__inr__m__k._kr__ex__;
akr__ex__ = (void *)kr__ex__;
v = (void *)(void *)((int)v * (int)yr__ex__);
pc = &applyr__m__k;
break; }
case _r__t__r__m__outr__m__k_kt: {
void *xr__ex__ = _c->u._r__t__r__m__outr__m__k._xr__ex__;
void *envr__ex__ = _c->u._r__t__r__m__outr__m__k._envr__ex__;
void *kr__ex__ = _c->u._r__t__r__m__outr__m__k._kr__ex__;
k = (void *)ktr_r__t__r__m__inr__m__k(v,kr__ex__);
exprr__ex__ = (void *)xr__ex__;
envr__m__cps = (void *)envr__ex__;
pc = &valuer__m__ofr__m__cps;
break; }
case _sr1r__m__inr__m__k_kt: {
void *kr__ex__ = _c->u._sr1r__m__inr__m__k._kr__ex__;
akr__ex__ = (void *)kr__ex__;
v = (void *)(void *)((int)v - 1);
pc = &applyr__m__k;
break; }
case _zrr__m__inr__m__k_kt: {
void *kr__ex__ = _c->u._zrr__m__inr__m__k._kr__ex__;
akr__ex__ = (void *)kr__ex__;
v = (void *)(v == 0);
pc = &applyr__m__k;
break; }
case _ifr__m__inr__m__k_kt: {
void *cr__ex__ = _c->u._ifr__m__inr__m__k._cr__ex__;
void *ar__ex__ = _c->u._ifr__m__inr__m__k._ar__ex__;
void *envr__ex__ = _c->u._ifr__m__inr__m__k._envr__ex__;
void *kr__ex__ = _c->u._ifr__m__inr__m__k._kr__ex__;
if(v) {
  k = (void *)kr__ex__;
exprr__ex__ = (void *)cr__ex__;
envr__m__cps = (void *)envr__ex__;
pc = &valuer__m__ofr__m__cps;

} else {
  k = (void *)kr__ex__;
envr__m__cps = (void *)envr__ex__;
exprr__ex__ = (void *)ar__ex__;
pc = &valuer__m__ofr__m__cps;

}
break; }
case _thrr__m__outr__m__k_kt: {
void *er__ex__ = _c->u._thrr__m__outr__m__k._er__ex__;
void *envr__ex__ = _c->u._thrr__m__outr__m__k._envr__ex__;
k = (void *)ktr_thrr__m__inr__m__k(v);
exprr__ex__ = (void *)er__ex__;
envr__m__cps = (void *)envr__ex__;
pc = &valuer__m__ofr__m__cps;
break; }
case _thrr__m__inr__m__k_kt: {
void *vr__ex__ = _c->u._thrr__m__inr__m__k._vr__ex__;
akr__ex__ = (void *)vr__ex__;
pc = &applyr__m__k;
break; }
case _letr__m__inr__m__k_kt: {
void *br__ex__ = _c->u._letr__m__inr__m__k._br__ex__;
void *envr__ex__ = _c->u._letr__m__inr__m__k._envr__ex__;
void *kr__ex__ = _c->u._letr__m__inr__m__k._kr__ex__;
k = (void *)kr__ex__;
exprr__ex__ = (void *)br__ex__;
envr__m__cps = (void *)envrr_extendr__m__env(v,envr__ex__);
pc = &valuer__m__ofr__m__cps;
break; }
case _appr__m__inr__m__k_kt: {
void *cr__ex__ = _c->u._appr__m__inr__m__k._cr__ex__;
void *kr__ex__ = _c->u._appr__m__inr__m__k._kr__ex__;
ckr__ex__ = (void *)kr__ex__;
clr__ex__ = (void *)cr__ex__;
cy = (void *)v;
pc = &applyr__m__closure;
break; }
case _appr__m__outr__m__k_kt: {
void *ranr__ex__ = _c->u._appr__m__outr__m__k._ranr__ex__;
void *envr__ex__ = _c->u._appr__m__outr__m__k._envr__ex__;
void *kr__ex__ = _c->u._appr__m__outr__m__k._kr__ex__;
k = (void *)ktr_appr__m__inr__m__k(v,kr__ex__);
exprr__ex__ = (void *)ranr__ex__;
envr__m__cps = (void *)envr__ex__;
pc = &valuer__m__ofr__m__cps;
break; }
}
}

void valuer__m__ofr__m__cps()
{
expr* _c = (expr*)exprr__ex__;
switch (_c->tag) {
case _const_expr: {
void *expr = _c->u._const._cexp;
akr__ex__ = (void *)k;
v = (void *)expr;
pc = &applyr__m__k;
break; }
case _mult_expr: {
void *xr1 = _c->u._mult._nexpr1;
void *xr2 = _c->u._mult._nexpr2;
k = (void *)ktr_r__t__r__m__outr__m__k(xr2,envr__m__cps,k);
exprr__ex__ = (void *)xr1;
pc = &valuer__m__ofr__m__cps;
break; }
case _subr1_expr: {
void *x = _c->u._subr1._nexp;
k = (void *)ktr_sr1r__m__inr__m__k(k);
exprr__ex__ = (void *)x;
pc = &valuer__m__ofr__m__cps;
break; }
case _zero_expr: {
void *x = _c->u._zero._nexp;
k = (void *)ktr_zrr__m__inr__m__k(k);
exprr__ex__ = (void *)x;
pc = &valuer__m__ofr__m__cps;
break; }
case _if_expr: {
void *test = _c->u._if._test;
void *conseq = _c->u._if._conseq;
void *alt = _c->u._if._alt;
k = (void *)ktr_ifr__m__inr__m__k(conseq,alt,envr__m__cps,k);
exprr__ex__ = (void *)test;
pc = &valuer__m__ofr__m__cps;
break; }
case _letcc_expr: {
void *body = _c->u._letcc._body;
envr__m__cps = (void *)envrr_extendr__m__env(k,envr__m__cps);
exprr__ex__ = (void *)body;
pc = &valuer__m__ofr__m__cps;
break; }
case _throw_expr: {
void *kr__m__exp = _c->u._throw._kexp;
void *er__m__exp = _c->u._throw._vexp;
k = (void *)ktr_thrr__m__outr__m__k(er__m__exp,envr__m__cps);
exprr__ex__ = (void *)kr__m__exp;
pc = &valuer__m__ofr__m__cps;
break; }
case _let_expr: {
void *e = _c->u._let._exp;
void *body = _c->u._let._body;
k = (void *)ktr_letr__m__inr__m__k(body,envr__m__cps,k);
exprr__ex__ = (void *)e;
pc = &valuer__m__ofr__m__cps;
break; }
case _var_expr: {
void *expr = _c->u._var._n;
ekr__ex__ = (void *)k;
envrr__ex__ = (void *)envr__m__cps;
ey = (void *)expr;
pc = &applyr__m__env;
break; }
case _lambda_expr: {
void *body = _c->u._lambda._body;
akr__ex__ = (void *)k;
v = (void *)closr_closure(body,envr__m__cps);
pc = &applyr__m__k;
break; }
case _app_expr: {
void *rator = _c->u._app._rator;
void *rand = _c->u._app._rand;
k = (void *)ktr_appr__m__outr__m__k(rand,envr__m__cps,k);
exprr__ex__ = (void *)rator;
pc = &valuer__m__ofr__m__cps;
break; }
}
}

int mount_tram ()
{
srand (time (NULL));
jmp_buf jb;
_trstr trstr;
void *dismount;
int _status = setjmp(jb);
trstr.jmpbuf = &jb;
dismount = &trstr;
if(!_status) {
k= (void *)ktr_emptyr__m__k(dismount);
for(;;) {
pc();
}
}
return 0;
}
