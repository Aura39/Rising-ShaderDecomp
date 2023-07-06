float4 g_Ambient;
float4 g_LightDirection;
float4 g_MatrialColor;
float4x4 g_WorldMatrix;
float4x4 g_WorldViewProjMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord7 : TEXCOORD7;
	float2 texcoord : TEXCOORD;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float3 r1;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	o.position.x = dot(r0, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r0, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r0, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(r0, transpose(g_WorldViewProjMatrix)[3]);
	r0.x = (0 < i.position.w) ? 1 : 0;
	r0.y = -0.5 + i.position.w;
	r0.z = r0.x * r0.y + 0.5;
	r0.xy = i.position.xy;
	r0.xyz = -r0.xyz + float3(-0.5, -0.5, 0);
	r1.x = dot(r0.xyz, transpose(g_WorldMatrix)[0].xyz);
	r1.y = dot(r0.xyz, transpose(g_WorldMatrix)[1].xyz);
	r1.z = dot(r0.xyz, transpose(g_WorldMatrix)[2].xyz);
	r0.xyz = normalize(r1.xyz);
	r0.x = dot(-g_LightDirection.xyz, r0.xyz);
	r0.x = r0.x * 0.5 + 0.5;
	r0.xyz = r0.xxx + g_Ambient.xyz;
	o.texcoord7.xyz = r0.xyz * g_MatrialColor.xyz;
	r0.w = g_MatrialColor.w;
	o.texcoord7.w = r0.w + g_Ambient.w;
	o.texcoord = i.texcoord.xy;

	return o;
}
