sampler g_Sampler0 : register(s13);
sampler g_Sampler1 : register(s14);
sampler g_Sampler2 : register(s15);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
	float4 color : COLOR;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	r0 = tex2D(g_Sampler1, i.texcoord1);
	r1 = tex2D(g_Sampler0, i.texcoord);
	r2.w = dot(r1.wxw, i.texcoord2.xyz);
	r0.xyz = r1.xyz * i.texcoord2.xxx + i.texcoord2.yyy;
	r2.xyz = r0.xyz + i.texcoord2.zzz;
	r1 = r2 * i.color;
	r0.xyz = r2.xyz * -i.color.xyz + 1;
	o.w = r0.w * r1.w;
	r2 = tex2D(g_Sampler2, i.texcoord1);
	r3.xyz = -r2.xyz + 1;
	r3.xyz = r3.xyz + r3.xyz;
	r0.xyz = r3.xyz * -r0.xyz + 1;
	r0.w = dot(r2.x, r1.x) + 0;
	r3.xyz = r2.xyz + -0.5;
	o.x = (r3.x >= 0) ? r0.x : r0.w;
	r0.x = dot(r2.y, r1.y) + 0;
	r0.w = dot(r2.z, r1.z) + 0;
	o.yz = (r3.yz >= 0) ? r0.yz : r0.xw;

	return o;
}
