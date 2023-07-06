float3 g_CamPos;
float4x4 g_WorldMatrix_vtx;
float4x4 g_WorldViewProjMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float3 r0;
	o.position.x = dot(i.position, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(i.position, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(i.position, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(i.position, transpose(g_WorldViewProjMatrix)[3]);
	r0.x = dot(i.position, transpose(g_WorldMatrix_vtx)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix_vtx)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix_vtx)[2]);
	o.texcoord1 = r0.xyz + -g_CamPos.xyz;
	o.texcoord = i.texcoord.xy;

	return o;
}
