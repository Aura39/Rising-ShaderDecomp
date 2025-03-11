float4x4 g_ViewProjMatrix : register(c54);
float4x4 g_WorldMatrix : register(c58);

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

VS_OUT main(float4 position : POSITION)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0 = position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r0, transpose(g_WorldMatrix)[0]);
	r1.y = dot(r0, transpose(g_WorldMatrix)[1]);
	r1.z = dot(r0, transpose(g_WorldMatrix)[2]);
	r1.w = dot(r0, transpose(g_WorldMatrix)[3]);
	o.position.x = dot(r1, transpose(g_ViewProjMatrix)[0]);
	o.position.y = dot(r1, transpose(g_ViewProjMatrix)[1]);
	o.position.z = dot(r1, transpose(g_ViewProjMatrix)[2]);
	o.position.w = dot(r1, transpose(g_ViewProjMatrix)[3]);
	r0.x = (0.5 >= position.w) ? 1 : 0;
	r0.w = 1;
	r0.yz = (float2(1, 1.5) < position.ww) ? 1 : 0;
	r1.xyz = -r0.xzw + float3(0, 0, 1);
	o.texcoord.xyw = r0.yyy * r1.xyz + r0.xzw;
	o.texcoord.z = r0.y;

	return o;
}
