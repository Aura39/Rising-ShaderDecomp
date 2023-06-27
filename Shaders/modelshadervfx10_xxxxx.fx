float4 CubeParam;
sampler RefractMap_sampler;
float4 Refract_Param;
float4 SoftPt_Rate;
float4 ambient_rate;
float4 finalcolor_enhance;
float3 fog;
float4 g_TargetUvParam;
float4 lightpos;
sampler normalmap_sampler;
float4 prefogcolor_enhance;
float4 tile;

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = float4(-0, -0, -0, -1) + i.color;
	r1.zw = float2(-0.5, 0.5);
	r0 = SoftPt_Rate.y * r0 + -r1.zzzw;
	r1.w = ambient_rate.w;
	r1 = r0.w * r1.w + -0.01;
	clip(r1);
	r1.xyz = i.texcoord3.xyz;
	r2.xyz = r1.yzx * i.texcoord2.zxy;
	r1.xyz = i.texcoord2.yzx * r1.zxy + -r2.xyz;
	r2.xy = i.texcoord.zw * tile.xy + tile.zw;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.xyz = r1.xyz * -r2.yyy;
	r1.w = r2.x * i.texcoord2.w;
	r1.xyz = r1.www * i.texcoord2.xyz + r1.xyz;
	r1.xyz = r2.zzz * i.texcoord3.xyz + r1.xyz;
	r1.w = dot(r1.xyz, r1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r1.xyz = r1.xyz * r1.www + -i.texcoord3.xyz;
	r2.xy = CubeParam.ww * r1.xy + i.texcoord3.xy;
	r1.xyz = r1.xyz * CubeParam.www;
	r1.xyz = Refract_Param.zzz * r1.xyz + i.texcoord3.xyz;
	r1.x = dot(lightpos.xyz, r1.xyz);
	r1.y = 1 / i.texcoord8.w;
	r1.yz = r1.yy * i.texcoord8.xy;
	r1.yz = r1.yz * float2(-0.5, 0.5) + 0.5;
	r1.yz = r1.yz + g_TargetUvParam.xy;
	r1.yz = r2.xy * -Refract_Param.yy + r1.yz;
	r2 = tex2D(RefractMap_sampler, r1.yzzw);
	r1.yzw = lerp(r2.xyz, r0.xyz, Refract_Param.xxx);
	r0.x = r0.w * ambient_rate.w;
	r0.w = r0.x * prefogcolor_enhance.w;
	r1.yzw = r1.yzw * ambient_rate.xyz;
	r2.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.x = r1.x + -r2.x;
	r1.x = r1.x * 0.5 + 1;
	r1.xyz = r1.xxx * r1.yzw;
	r2.xyz = fog.xyz;
	r1.xyz = r1.xyz * prefogcolor_enhance.xyz + -r2.xyz;
	r0.xyz = i.texcoord1.www * r1.xyz + fog.xyz;
	o = r0 * finalcolor_enhance;

	return o;
}
