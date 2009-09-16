/**
 *  Rome nginx module
 *  Divide and conquer
 *
 *  Author: Joseph Wecker <joseph.wecker@gmail.com>
 *  Copyright: 2009 Joseph Wecker, All Rights Reserved
 *
 *  Probably will need a lot of work, as it's my first nginx module and there
 *  is a lot to do...  Also forgive the verbose comments.  It's for my own sake
 *  to internalize how this basically works.
 *
 *  TODO:
 *    - Get all the configuration stuff figured out and basically implemented
 *    - Pass through when it is turned off
 */

#include <ngx_config.h>
#include <ngx_core.h>
#include <ngx_http.h>

/* To hold all of the configuration options for this module */
typedef struct {
	ngx_flag_t    enable;
} ngx_http_rome_loc_conf_t;

static char *ngx_http_rome(ngx_conf_t *cf, ngx_command_t *cmd, void *conf);

static ngx_command_t  ngx_http_rome_commands[] = {

  { ngx_string("rome"),
    NGX_HTTP_LOC_CONF|NGX_CONF_NOARGS,
    ngx_http_rome,
    0,
    0,
    NULL },

    ngx_null_command
};

static u_char  ngx_rome[] = "hello world! From Rome...";

static ngx_http_module_t  ngx_http_rome_module_ctx = {
  NULL,                          /* preconfiguration */
  NULL,                          /* postconfiguration */

  NULL,                          /* create main configuration */
  NULL,                          /* init main configuration */

  NULL,                          /* create server configuration */
  NULL,                          /* merge server configuration */

  NULL,                          /* create location configuration */
  NULL                           /* merge location configuration */
};

ngx_module_t ngx_http_rome_module = {
  NGX_MODULE_V1,
  &ngx_http_rome_module_ctx, /* module context */
  ngx_http_rome_commands,   /* module directives */
  NGX_HTTP_MODULE,               /* module type */
  NULL,                          /* init master */
  NULL,                          /* init module */
  NULL,                          /* init process */
  NULL,                          /* init thread */
  NULL,                          /* exit thread */
  NULL,                          /* exit process */
  NULL,                          /* exit master */
  NGX_MODULE_V1_PADDING
};

static ngx_int_t ngx_http_rome_handler(ngx_http_request_t *r)
{
  ngx_buf_t    *b;
  ngx_chain_t   out;

  r->headers_out.content_type.len = sizeof("text/plain") - 1;
  r->headers_out.content_type.data = (u_char *) "text/plain";

  b = ngx_pcalloc(r->pool, sizeof(ngx_buf_t));

  out.buf = b;
  out.next = NULL;

  b->pos = ngx_rome;
  b->last = ngx_rome + sizeof(ngx_rome);
  b->memory = 1;
  b->last_buf = 1;

  r->headers_out.status = NGX_HTTP_OK;
  r->headers_out.content_length_n = sizeof(ngx_rome);
  ngx_http_send_header(r);

  return ngx_http_output_filter(r, &out);
}

static char *ngx_http_rome(ngx_conf_t *cf, ngx_command_t *cmd, void *conf)
{
  ngx_http_core_loc_conf_t  *clcf;

  clcf = ngx_http_conf_get_module_loc_conf(cf, ngx_http_core_module);
  clcf->handler = ngx_http_rome_handler;

  return NGX_CONF_OK;
}
