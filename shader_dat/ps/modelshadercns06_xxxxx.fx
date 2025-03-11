sampler Color_1_sampler : register(s0);
float3 ambient_rate : register(c40);
float4 g_All_Offset : register(c55);
float4 lightpos : register(c46);
float normalmap_rate : register(c41);
sampler normalmap_sampler : register(s1);
float4 prefogcolor_enhance : register(c56);
float4 tile : register(c44);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float3 r2;
	float3 r3;
	float3 r4;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.5;
	r0.xyz = r0.xyz * ambient_rate.xyz;
	clip(r1);
	r1.xy = g_All_Offset.xy;
	r1.xy = i.texcoord.xy * tile.xy + r1.xy;
	r1 = tex2D(normalmap_sampler, r1);
	r1.xyz = r1.xyz * 2 + -1;
	r2.x = r1.x * i.texcoord2.w;
	r2.yz = r1.yz * float2(2, -1);
	r1.xyz = normalize(r2.xyz);
	r2.xyz = normalize(i.texcoord2.xyz);
	r3.xyz = normalize(i.texcoord3.xyz);
	r4.xyz = r2.zxy * r3.yzx;
	r4.xyz = r2.yzx * r3.zxy + -r4.xyz;
	r4.xyz = r1.yyy * r4.xyz;
	r1.xyw = r1.xxx * r2.xyz + r4.xyz;
	r1.xyz = r1.zzz * r3.xyz + r1.xyw;
	r0.w = dot(r1.xyz, r1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r1.xyz = r1.xyz * r0.www + -r3.xyz;
	r1.xyz = normalmap_rate.xxx * r1.xyz + r3.xyz;
	r0.w = dot(lightpos.xyz, r3.xyz);
	r1.x = dot(lightpos.xyz, r1.xyz);
	r0.w = -r0.w + r1.x;
	r1.z = 1;
	r0.w = r0.w * normalmap_rate.x + r1.z;
	r0.xyz = r0.www * r0.xyz;
	r0.w = 1;
	o = r0 * prefogcolor_enhance;

	return o;
}
