void *exprr__ex__, *envr__m__cps, *k, *clr__ex__, *cy, *ckr__ex__, *envrr__ex__, *ey, *ekr__ex__, *akr__ex__, *v;

void (*pc)();

void valuer__m__ofr__m__cps();
struct expr;
typedef struct expr expr;
struct expr {
  enum {
    _const_expr,
    _var_expr,
    _if_expr,
    _mult_expr,
    _subr1_expr,
    _zero_expr,
    _letcc_expr,
    _throw_expr,
    _let_expr,
    _lambda_expr,
    _app_expr
  } tag;
  union {
    struct { void *_cexp; } _const;
    struct { void *_n; } _var;
    struct { void *_test; void *_conseq; void *_alt; } _if;
    struct { void *_nexpr1; void *_nexpr2; } _mult;
    struct { void *_nexp; } _subr1;
    struct { void *_nexp; } _zero;
    struct { void *_body; } _letcc;
    struct { void *_kexp; void *_vexp; } _throw;
    struct { void *_exp; void *_body; } _let;
    struct { void *_body; } _lambda;
    struct { void *_rator; void *_rand; } _app;
  } u;
};

void *exprr_const(void *cexp);
void *exprr_var(void *n);
void *exprr_if(void *test, void *conseq, void *alt);
void *exprr_mult(void *nexpr1, void *nexpr2);
void *exprr_subr1(void *nexp);
void *exprr_zero(void *nexp);
void *exprr_letcc(void *body);
void *exprr_throw(void *kexp, void *vexp);
void *exprr_let(void *exp, void *body);
void *exprr_lambda(void *body);
void *exprr_app(void *rator, void *rand);

void applyr__m__k();
struct kt;
typedef struct kt kt;
struct kt {
  enum {
    _emptyr__m__k_kt,
    _r__t__r__m__inr__m__k_kt,
    _r__t__r__m__outr__m__k_kt,
    _sr1r__m__inr__m__k_kt,
    _zrr__m__inr__m__k_kt,
    _ifr__m__inr__m__k_kt,
    _thrr__m__outr__m__k_kt,
    _thrr__m__inr__m__k_kt,
    _letr__m__inr__m__k_kt,
    _appr__m__inr__m__k_kt,
    _appr__m__outr__m__k_kt
  } tag;
  union {
    struct { void *_dismount; } _emptyr__m__k;
    struct { void *_yr__ex__; void *_kr__ex__; } _r__t__r__m__inr__m__k;
    struct { void *_xr__ex__; void *_envr__ex__; void *_kr__ex__; } _r__t__r__m__outr__m__k;
    struct { void *_kr__ex__; } _sr1r__m__inr__m__k;
    struct { void *_kr__ex__; } _zrr__m__inr__m__k;
    struct { void *_cr__ex__; void *_ar__ex__; void *_envr__ex__; void *_kr__ex__; } _ifr__m__inr__m__k;
    struct { void *_er__ex__; void *_envr__ex__; } _thrr__m__outr__m__k;
    struct { void *_vr__ex__; } _thrr__m__inr__m__k;
    struct { void *_br__ex__; void *_envr__ex__; void *_kr__ex__; } _letr__m__inr__m__k;
    struct { void *_cr__ex__; void *_kr__ex__; } _appr__m__inr__m__k;
    struct { void *_ranr__ex__; void *_envr__ex__; void *_kr__ex__; } _appr__m__outr__m__k;
  } u;
};

void *ktr_emptyr__m__k(void *dismount);
void *ktr_r__t__r__m__inr__m__k(void *yr__ex__, void *kr__ex__);
void *ktr_r__t__r__m__outr__m__k(void *xr__ex__, void *envr__ex__, void *kr__ex__);
void *ktr_sr1r__m__inr__m__k(void *kr__ex__);
void *ktr_zrr__m__inr__m__k(void *kr__ex__);
void *ktr_ifr__m__inr__m__k(void *cr__ex__, void *ar__ex__, void *envr__ex__, void *kr__ex__);
void *ktr_thrr__m__outr__m__k(void *er__ex__, void *envr__ex__);
void *ktr_thrr__m__inr__m__k(void *vr__ex__);
void *ktr_letr__m__inr__m__k(void *br__ex__, void *envr__ex__, void *kr__ex__);
void *ktr_appr__m__inr__m__k(void *cr__ex__, void *kr__ex__);
void *ktr_appr__m__outr__m__k(void *ranr__ex__, void *envr__ex__, void *kr__ex__);

void applyr__m__env();
void applyr__m__closure();
struct clos;
typedef struct clos clos;
struct clos {
  enum {
    _closure_clos
  } tag;
  union {
    struct { void *_bodyr__ex__; void *_envr__ex__; } _closure;
  } u;
};

void *closr_closure(void *bodyr__ex__, void *envr__ex__);

struct envr;
typedef struct envr envr;
struct envr {
  enum {
    _emptyr__m__env_envr,
    _extendr__m__env_envr
  } tag;
  union {
    struct { char dummy; } _emptyr__m__env;
    struct { void *_ar__ex__; void *_envr__ex__; } _extendr__m__env;
  } u;
};

void *envrr_emptyr__m__env();
void *envrr_extendr__m__env(void *ar__ex__, void *envr__ex__);

int main();
int mount_tram();

struct _trstr;
typedef struct _trstr _trstr;
struct _trstr {
  jmp_buf *jmpbuf;
  int value;
};

