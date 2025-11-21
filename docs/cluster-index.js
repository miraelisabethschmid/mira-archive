// cluster-index.js – liest alle Nodes aus cluster.json und aktualisiert ihren Status

async function fetchJSON(url) {
  try {
    const res = await fetch(url, { cache: "no-store" });
    if (!res.ok) return null;
    return await res.json();
  } catch (e) {
    return null;
  }
}

async function updateCluster() {
  const clusterUrl = "./cluster.json";
  const cluster = await fetchJSON(clusterUrl);

  if (!cluster || !cluster.nodes) {
    console.error("cluster.json konnte nicht geladen werden");
    return;
  }

  const updatedNodes = [];

  for (const node of cluster.nodes) {
    const heartbeatUrl =
      `https://raw.githubusercontent.com/${node.repo}/main/badges/health.json`;

    const hb = await fetchJSON(heartbeatUrl);

    if (!hb) {
      updatedNodes.push({
        ...node,
        status: "offline",
        last_heartbeat: null,
        hash: null
      });
      continue;
    }

    updatedNodes.push({
      ...node,
      status: hb.status || "unknown",
      last_heartbeat: hb.timestamp || null,
      hash: hb.hash || null
    });
  }

  const newCluster = {
    ...cluster,
    nodes: updatedNodes,
    updated: new Date().toISOString()
  };

  console.log("Cluster aktualisiert:", newCluster);

  // In GitHub Pages kann man nicht schreiben, also geben wir es zurück
  return newCluster;
}

updateCluster();
