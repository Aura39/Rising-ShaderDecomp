float3 g_CamPos;
sampler g_Sampler2v;
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
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0 = i.texcoord.xyxx * float4(1, 1, 0, 0) + float4(0, 0, 0, 1);
	r0 = tex2Dlod(g_Sampler2v, r0);
	r1.z = r0.y + i.position.z;
	o.texcoord.z = r0.y;
	r1.xyw = i.position.xyw;
	o.position.x = dot(r1, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r1, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r1, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(r1, transpose(g_WorldViewProjMatrix)[3]);
	r0.x = dot(i.position, transpose(g_WorldMatrix_vtx)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix_vtx)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix_vtx)[2]);
	o.texcoord1 = r0.xyz + -g_CamPos.xyz;
	o.texcoord.xyw = float3(1, 1, 0) * i.texcoord.xyx;

	return o;
}
