# Rancher NFS

By default in NFSv4, the NFS client doesn't have root access to the shared directory on the host. If you need to enable the root access for NFS client, add `no_root_squash` to `/etc/export`:

```
/directory/to/share    your_client_ip(rw,sync,no_root_squash,no_subtree_check)
```
