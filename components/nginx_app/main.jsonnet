local kr8 = std.extVar('kr8');

[
  // deployment
  {
    metadata: { name: 'nginx-deployment-' + kr8.release_name },
    kind: 'Deployment',
    apiVersion: 'apps/v1',
    spec: {
      selector: { matchLabels: { app: kr8.release_name } },
      replicas: kr8.replicas,
      template: {
        spec: {
          containers: [
            {
              ports: [{ containerPort: 8080 }],
              image: 'nginx:1.8',
              name: kr8.release_name,
            },
          ],
        },
        metadata: { labels: { app: kr8.release_name } },
      },
    },
  },

  // service
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: { name: kr8.release_name },
    spec: {
      ports: [{ name: 'http', port: 8080, targetPort: 8080 }],
      selector: { app: kr8.release_name },
    },
  },

  // namespace
  if kr8.manage_namespace then {
    apiVersion: 'v1',
    kind: 'Namespace',
    metadata: { name: kr8.namespace },
  },
]
