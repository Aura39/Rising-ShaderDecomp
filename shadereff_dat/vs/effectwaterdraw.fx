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
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	r0.x = dot(i.position, transpose(g_WorldMatrix_vtx)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix_vtx)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix_vtx)[2]);
	o.texcoord1 = r0.xyz + -g_CamPos.xyz;
	r0.x = dot(i.position, transpose(g_WorldViewProjMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldViewProjMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldViewProjMatrix)[2]);
	r0.w = dot(i.position, transpose(g_WorldViewProjMatrix)[3]);
	o.position = r0;
	o.texcoord = i.texcoord.xy;
	o.texcoord2 = r0;
	o.texcoord3 = r0;

	return o;
}
