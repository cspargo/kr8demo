{
  _cluster+: {
    cluster_name: 'cluster1',
    cluster_type: 'kind',
    dns_domain: 'example.com',
  },

  _components+: {
    myapp1: { path: 'components/nginx_app' },
    myapp2: { path: 'components/nginx_app' },
  },

  // component params
  myapp1+: {
    manage_namespace: true,
    release_name: 'myapp1',
    namespace: self.release_name,
    replicas: 4,
  },

  myapp2+: self.myapp1 {
    release_name: 'myapp2',
  },

  myapp_common+: {
    release_name: 'myapp-common-in-' + $._cluster.cluster_name,
  },
}
