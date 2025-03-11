float4x4 g_ViewProjMatrix : register(c8);
float4x4 g_WorldMatrix : register(c16);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	r0.w = dot(i.position, transpose(g_WorldMatrix)[3]);
	o.position.x = dot(r0, transpose(g_ViewProjMatrix)[0]);
	o.position.y = dot(r0, transpose(g_ViewProjMatrix)[1]);
	o.position.z = dot(r0, transpose(g_ViewProjMatrix)[2]);
	o.position.w = dot(r0, transpose(g_ViewProjMatrix)[3]);
	o.texcoord = i.texcoord.xy;

	return o;
}
