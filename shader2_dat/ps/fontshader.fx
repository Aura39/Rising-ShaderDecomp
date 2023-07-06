sampler g_Sampler0;
sampler g_Sampler1;

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
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1.xyz = r0.xyz * i.texcoord2.xxx + i.texcoord2.yyy;
	r0.w = dot(r0.wxw, i.texcoord2.xyz);
	r0.xyz = r1.xyz + i.texcoord2.zzz;
	r0 = r0 * i.color;
	r1 = tex2D(g_Sampler1, i.texcoord1);
	o.w = r0.w * r1.w;
	o.xyz = r0.xyz;

	return o;
}
